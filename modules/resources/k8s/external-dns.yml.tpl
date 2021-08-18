---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: ${k8s_sa_name}
  namespace: ${k8s_namespace}
  annotations:
    eks.amazonaws.com/role-arn: ${iam_role_arn}

---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: external-dns
rules:
  - apiGroups: [""]
    resources: ["services","endpoints","pods"]
    verbs: ["get","watch","list"]
  - apiGroups: ["extensions","networking.k8s.io"]
    resources: ["ingresses"]
    verbs: ["get","watch","list"]
  - apiGroups: [""]
    resources: ["nodes"]
    verbs: ["list","watch"]

---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: external-dns-viewer
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: external-dns
subjects:
  - kind: ServiceAccount
    name: ${k8s_sa_name}
    namespace: ${k8s_namespace}

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: external-dns
  namespace: ${k8s_namespace}
spec:
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app: external-dns
  template:
    metadata:
      labels:
        app: external-dns
    spec:
      serviceAccountName: ${k8s_sa_name}
      securityContext:
        fsGroup: 65534
      containers:
        - name: external-dns
          image: ${image_name}:${image_tag}  # k8s.gcr.io/external-dns/external-dns:v0.9.0
          args:
            - --source=service
            - --source=ingress
            - --provider=aws
            - --registry=txt
            - --txt-owner-id=${txt_owner_id}
