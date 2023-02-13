# Orkes Container Customizations

In this repository you can find the Docker image build files for changing base images using multistage docker builds. This is useful if you have requirements to change the base OS image to something customized for your organization. 

You should test out the builds before using this in production. The templates are based on Alpine Linux.

To run this you can use the reference build.sh script using the parameters as shown below:

```
export CONTAINER_REPO_NAME_CONDUCTOR_SERVER=orkes-conductor/orkes-conductor-server
export CONTAINER_REPO_NAME_CONDUCTOR_WORKER=orkes-conductor/orkes-conductor-workers
export CONTAINER_IMAGE_VERSION_TAG_PREFIX=wrapped
export CONDUCTOR_VERSION=2.3.27
```
