resource "helm_release" "jenkins" {
  provider   = helm.eks
  name       = "jenkins"
  namespace  = kubernetes_namespace.jenkins.metadata[0].name
  chart      = "oci://ghcr.io/jenkinsci/helm-charts/jenkins"
  version    = "5.6.0"

  values = [
    file("${path.module}/jenkins_values.yaml")
  ]

  depends_on = [
    kubernetes_namespace.jenkins,
    kubernetes_storage_class.jenkins_sc,
    null_resource.update_kubeconfig,
    module.eks,
    data.aws_eks_cluster.eks,
    data.aws_eks_cluster_auth.eks
  ]
}
