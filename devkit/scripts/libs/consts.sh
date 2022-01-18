STDOUT="/tmp/portainer-devkit.log"

USER_HOME="/home/workspace"
MOUNT_POINT="$USER_HOME/src"

TMUX_NAME_WEBPACK="webpack"


NETWORK_NAME="portainer-devkit"
SUBNET="192.168.100.0/24"
GATEWAY="192.168.100.100"


TARGET_IP_K8S="192.168.100.1"  # hard code in yaml file
TARGET_IP_SWARM="192.168.100.2"
TARGET_IP_DOCKER="192.168.100.3"
TARGET_IP_NOMAD="192.168.100.4"
TARGET_IP_WORKSPACE="192.168.100.10"


TARGET_NAME_K8S="portainer-k8s-control-plane"
TARGET_NAME_SWARM="portainer-swarm"
TARGET_NAME_DOCKER="portainer-docker"
TARGET_NAME_NOMAD="portainer-nomad"
TARGET_NAME_WORKSPACE="portainer-workspace"

AGENT_NAME_K8S="portainer-k8s-agent"
AGENT_NAME_SWARM="portainer_edge_agent"
AGENT_NAME_DOCKER="portainer-docker-agent"

TARGET_NAME_K8S_KIND="portainer-k8s"

IMAGE_NAME_AGENT="mcpacino/portainer-devkit-agent"
IMAGE_NAME_WORKSPACE="mcpacino/portainer-devkit-workspace"
IMAGE_NAME_AGENT_DEFAULT="${IMAGE_NAME_AGENT}"

# dlv ports are hard coded in launch.json and some yaml file
DLV_PORT_PORTAINER_WORKSPACE=23451
DLV_PORT_PORTAINER_K8S=23452
DLV_PORT_AGENT_K8S=23461
DLV_PORT_AGENT_SWARM=23462
DLV_PORT_AGENT_DOCKER=23463


PORTAINER_PORT_HTTP_WORKSPACE=9000
PORTAINER_PORT_HTTPS_WORKSPACE=9443


PORTAINER_PORT_HTTP_K8S=19000
PORTAINER_PORT_HTTPS_K8S=19443


E_MSG="🔹"
E_OK="✅"
E_WARN="❎"
E_FAIL="❌"
E_FLAG="🏁️"
E_BUG="🐞"
E_ING="⏳"
E_INFO="ℹ️"
E_INFO="📢"

SSH_USER="devkit"
SSH_PASSWORD="portainer"

# portainer-agent
# portainer_edge_agent
