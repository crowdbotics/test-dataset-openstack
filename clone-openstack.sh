#!/bin/bash

GITHUB_ORG="https://github.com/openstack"

echo "=========================================="
echo "Cloning OpenStack Enterprise-Scale Subset"
echo "=========================================="

# ============================================
# TIER 1: Core Services (The "Applications")
# ============================================
CORE_SERVICES=(
    "nova"              # Compute - massive, calls everything
    "keystone"          # Identity - everyone calls this
    "glance"            # Images - called by Nova
    "neutron"           # Networking - complex plugins
    "cinder"            # Block storage
    "swift"             # Object storage
    "heat"              # Orchestration (IaC engine)
    "horizon"           # Django-based dashboard
    "placement"         # Resource tracking (split from Nova)
)

# ============================================
# TIER 2: Extended Services (More complexity)
# ============================================
EXTENDED_SERVICES=(
    "barbican"          # Secrets management
    "designate"         # DNS as a service
    "octavia"           # Load balancing (uses Nova underneath)
    "manila"            # Shared filesystem
    "ironic"            # Bare metal provisioning
    "magnum"            # Container orchestration on k8s
    "trove"             # Database as a service
    "sahara"            # Big data processing
    "murano"            # Application catalog
    "zaqar"             # Messaging service
)

# ============================================
# TIER 3: Oslo Libraries (Shared dependencies)
# Every service depends on multiple Oslo libs
# ============================================
OSLO_LIBS=(
    "oslo.config"
    "oslo.messaging"
    "oslo.db"
    "oslo.service"
    "oslo.log"
    "oslo.middleware"
    "oslo.policy"
    "oslo.serialization"
    "oslo.utils"
    "oslo.i18n"
    "oslo.concurrency"
    "oslo.cache"
    "oslo.context"
    "oslo.versionedobjects"
    "oslo.rootwrap"
    "oslo.privsep"
)

# ============================================
# TIER 4: Python Clients (Per-service SDKs)
# ============================================
CLIENTS=(
    "python-novaclient"
    "python-keystoneclient"
    "python-glanceclient"
    "python-neutronclient"
    "python-cinderclient"
    "python-swiftclient"
    "python-heatclient"
    "python-openstackclient"    # Unified CLI, depends on ALL clients
    "python-barbicanclient"
    "python-designateclient"
    "python-octaviaclient"
    "python-manilaclient"
    "python-ironicclient"
    "python-magnumclient"
    "python-troveclient"
)

# ============================================
# TIER 5: Deployment & IaC
# ============================================
DEPLOYMENT=(
    "devstack"                  # Dev environment scripts
    "openstack-ansible"         # Ansible-based deployment
    "kolla"                     # Container-based deployment
    "kolla-ansible"             # Ansible for Kolla
    "tripleo-common"            # TripleO shared code
    "heat-templates"            # Heat orchestration templates
    "tripleo-heat-templates"    # TripleO deployment templates
)

# ============================================
# TIER 6: Testing & CI Infrastructure
# ============================================
TESTING=(
    "tempest"                   # Integration test suite
    "grenade"                   # Upgrade testing
    "tempest-plugins"           # Additional tempest tests
    "devstack-gate"             # CI gate scripts
)

# ============================================
# TIER 7: Supporting Libraries & Tools
# ============================================
SUPPORTING=(
    "requirements"              # Global requirements coordination
    "governance"                # Project governance docs
    "releases"                  # Release management
    "taskflow"                  # Task/workflow library
    "stevedore"                 # Dynamic plugin loading
    "cliff"                     # Command-line framework
    "pbr"                       # Python build system
    "debtcollector"            # Deprecation library
    "futurist"                  # Async utilities
)

# ============================================
# Function to clone with error handling
# ============================================
clone_repo() {
    local repo=$1
    if [ -d "$repo" ]; then
        echo "  [SKIP] $repo (already exists)"
    else
        echo "  [CLONE] $repo"
        git clone --depth 1 "$GITHUB_ORG/$repo.git" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "    ✓ Success"
        else
            echo "    ✗ Failed (may not exist or private)"
        fi
    fi
}

# ============================================
# Clone everything by tier
# ============================================

echo ""
echo "TIER 1: Core Services (${#CORE_SERVICES[@]} repos)"
for repo in "${CORE_SERVICES[@]}"; do
    clone_repo "$repo"
done

echo ""
echo "TIER 2: Extended Services (${#EXTENDED_SERVICES[@]} repos)"
for repo in "${EXTENDED_SERVICES[@]}"; do
    clone_repo "$repo"
done

echo ""
echo "TIER 3: Oslo Libraries (${#OSLO_LIBS[@]} repos)"
for repo in "${OSLO_LIBS[@]}"; do
    clone_repo "$repo"
done

echo ""
echo "TIER 4: Python Clients (${#CLIENTS[@]} repos)"
for repo in "${CLIENTS[@]}"; do
    clone_repo "$repo"
done

echo ""
echo "TIER 5: Deployment & IaC (${#DEPLOYMENT[@]} repos)"
for repo in "${DEPLOYMENT[@]}"; do
    clone_repo "$repo"
done

echo ""
echo "TIER 6: Testing Infrastructure (${#TESTING[@]} repos)"
for repo in "${TESTING[@]}"; do
    clone_repo "$repo"
done

echo ""
echo "TIER 7: Supporting Libraries (${#SUPPORTING[@]} repos)"
for repo in "${SUPPORTING[@]}"; do
    clone_repo "$repo"
done

# ============================================
# Summary
# ============================================
echo ""
echo "=========================================="
echo "SUMMARY"
echo "=========================================="
TOTAL=$((${#CORE_SERVICES[@]} + ${#EXTENDED_SERVICES[@]} + ${#OSLO_LIBS[@]} + ${#CLIENTS[@]} + ${#DEPLOYMENT[@]} + ${#TESTING[@]} + ${#SUPPORTING[@]}))
echo "Total repositories targeted: $TOTAL"
echo ""
echo "Directory structure:"
find . -maxdepth 1 -type d | grep -v '^\.$' | wc -l | xargs echo "  Actual repos cloned:"
echo ""
echo "Next steps:"
echo "  1. Run dependency analysis: ./analyze-dependencies.sh"
echo "  2. Generate architecture diagram"
echo ""
