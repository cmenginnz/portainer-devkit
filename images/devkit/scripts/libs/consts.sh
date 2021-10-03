STDOUT="/tmp/portainer-dev-kit.log"


NETWORK_NAME="portainer-devkit"
SUBNET="192.168.100.0/24"
GATEWAY="192.168.100.100"


DEVKIT_NAME="portainer-devkit"
DEVKIT_IP="192.168.100.10"


TARGET_K8S_IP="192.168.100.1"  # hard code in yaml file
TARGET_SWARM_IP="192.168.100.2"
TARGET_DOCKER_IP="192.168.100.3"

TARGET_K8S_NAME="portainer-k8s"
TARGET_K8S_CONTAINER_NAME="portainer-k8s-control-plane"
TARGET_SWARM_NAME="portainer-swarm"
TARGET_DOCKER_NAME="portainer-docker"

PORTAINER_HTTP_PORT_IN_DEVKT=9000
PORTAINER_HTTPS_PORT_IN_DEVKT=9443

PORTAINER_HTTP_PORT_IN_K8S=19000
PORTAINER_HTTPS_PORT_IN_K8S=19443

# dlv ports are hard coded in launch.json and some yaml file
PORTAINER_DLV_PORT_IN_DEVKIT=23451
PORTAINER_DLV_PORT_IN_K8S=23452
AGENT_DLV_PORT_IN_K8S=23461
AGENT_DLV_PORT_IN_SWARM=23462
AGENT_DLV_PORT_IN_DOCKER=23463



# portainer-agent
# portainer_edge_agent
# ssh password