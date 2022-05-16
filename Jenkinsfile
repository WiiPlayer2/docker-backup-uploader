node('docker')
{
    checkout scm;

    def dockerBuild = load "ci/jenkins/dockerBuild.groovy";
    def causes = load "ci/jenkins/buildCauses.groovy";
    def gitFlow = load "ci/jenkins/gitFlow.groovy";

    def project = dockerBuild.prepare([
        imageName: 'backup-uploader',
        tag: 'latest',
        registry: 'registry.dark-link.info',
        registryCredentials: 'vserver-container-registry',
        dockerfile: './Dockerfile',
        platforms: [
            'linux/amd64',
            'linux/arm64',
            'linux/arm/v7',
        ],
    ]);

    dockerBuild.buildAndPublish(project);
}
