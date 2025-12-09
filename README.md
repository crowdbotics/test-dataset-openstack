# OpenStack Enterprise Test Dataset

An enterprise-scale test codebase consisting of 69 OpenStack repositories, designed to closely resemble the complexity of a real enterprise application environment (think Workday, Salesforce, or a major bank's internal systems).

## Purpose

This dataset provides a realistic enterprise codebase for testing and benchmarking:
- AI coding assistants and code analysis tools
- Dependency analysis and visualization tools
- Code search and navigation systems
- Large-scale refactoring tools
- Any tooling that needs to handle "enterprise complexity"

## What Makes This Enterprise-Like?

### Multiple Tiers of Dependencies
- **Circular dependencies** through shared libraries
- **Cross-service calls** (Nova calls Glance, Neutron, Cinder, Keystone, etc.)
- **Shared SDK/client libraries** that everyone depends on

### Multiple Languages & Frameworks
- **Python** - Primary language for all services
- **JavaScript** - Horizon dashboard (Django-based)
- **YAML/Jinja2** - Deployment templates, Ansible, Heat templates
- **Shell scripts** - DevStack, testing infrastructure
- **Go** - Some newer components

### Infrastructure as Code
- **Heat templates** - OpenStack-native IaC
- **Ansible playbooks** - Deployment automation
- **Kolla Dockerfiles** - Containerization
- **TripleO templates** - Meta-deployment for OpenStack-on-OpenStack

### Cross-Cutting Concerns
- Authentication flows span: Keystone -> oslo.policy -> all services
- Logging infrastructure: oslo.log -> everywhere
- Config management: oslo.config -> requirements -> every service
- Testing: tempest + plugins need to understand all service APIs

## Repository Structure

### Tier 1: Core Services (9 repos)
The main "applications" - compute, identity, storage, networking:
- `nova` - Compute (massive, calls everything)
- `keystone` - Identity (everyone calls this)
- `glance` - Images
- `neutron` - Networking (complex plugins)
- `cinder` - Block storage
- `swift` - Object storage
- `heat` - Orchestration (IaC engine)
- `horizon` - Django-based dashboard
- `placement` - Resource tracking

### Tier 2: Extended Services (10 repos)
Additional platform services:
- `barbican` - Secrets management
- `designate` - DNS as a service
- `octavia` - Load balancing
- `manila` - Shared filesystem
- `ironic` - Bare metal provisioning
- `magnum` - Container orchestration
- `trove` - Database as a service
- `sahara` - Big data processing
- `murano` - Application catalog
- `zaqar` - Messaging service

### Tier 3: Oslo Libraries (16 repos)
Shared dependencies - every service depends on multiple Oslo libs:
- `oslo.config`, `oslo.messaging`, `oslo.db`, `oslo.service`
- `oslo.log`, `oslo.middleware`, `oslo.policy`, `oslo.serialization`
- `oslo.utils`, `oslo.i18n`, `oslo.concurrency`, `oslo.cache`
- `oslo.context`, `oslo.versionedobjects`, `oslo.rootwrap`, `oslo.privsep`

### Tier 4: Python Clients (15 repos)
Per-service SDKs:
- `python-novaclient`, `python-keystoneclient`, `python-glanceclient`
- `python-neutronclient`, `python-cinderclient`, `python-swiftclient`
- `python-heatclient`, `python-openstackclient` (unified CLI, depends on ALL clients)
- `python-barbicanclient`, `python-designateclient`, `python-octaviaclient`
- `python-manilaclient`, `python-ironicclient`, `python-magnumclient`, `python-troveclient`

### Tier 5: Deployment & IaC (7 repos)
- `devstack` - Dev environment scripts
- `openstack-ansible` - Ansible-based deployment
- `kolla` - Container-based deployment
- `kolla-ansible` - Ansible for Kolla
- `tripleo-common` - TripleO shared code
- `heat-templates` - Heat orchestration templates
- `tripleo-heat-templates` - TripleO deployment templates

### Tier 6: Testing Infrastructure (4 repos)
- `tempest` - Integration test suite
- `grenade` - Upgrade testing
- `devstack-gate` - CI gate scripts

### Tier 7: Supporting Libraries (9 repos)
- `requirements` - Global requirements coordination
- `governance` - Project governance docs
- `releases` - Release management
- `taskflow` - Task/workflow library
- `stevedore` - Dynamic plugin loading
- `cliff` - Command-line framework
- `pbr` - Python build system
- `debtcollector` - Deprecation library
- `futurist` - Async utilities

## Code Statistics

### Overview
- **Total Repositories**: 69
- **Total Files**: 50,551
- **Total Lines**: 7,010,168
- **Lines of Code**: 5,522,479 (excluding comments and blank lines)
- **Comment Lines**: 492,382
- **Blank Lines**: 995,307

### Breakdown by Language

| Language | Files | Lines of Code | Comments | Blank Lines | Total Lines |
|----------|-------|---------------|----------|-------------|-------------|
| **Python** | 16,671 | 3,728,356 | 391,373 | 637,100 | 4,756,829 |
| **PO File** | 354 | 500,248 | 27,278 | 151,853 | 679,379 |
| **YAML** | 21,119 | 472,661 | 19,514 | 18,232 | 510,407 |
| **ReStructuredText** | 4,606 | 374,535 | 0 | 128,138 | 502,673 |
| **JSON** | 2,604 | 87,263 | 0 | 114 | 87,377 |
| **SVG** | 197 | 85,237 | 233 | 90 | 85,560 |
| **Bitbake** | 432 | 67,709 | 130 | 24,553 | 92,392 |
| **JavaScript** | 651 | 51,514 | 21,014 | 9,551 | 82,079 |
| **Shell** | 583 | 40,401 | 8,285 | 7,001 | 55,687 |
| **Jinja2** | 670 | 22,562 | 231 | 3,192 | 25,985 |
| **Pan** | 870 | 22,541 | 0 | 22 | 22,563 |
| **BASH** | 208 | 19,950 | 7,627 | 4,848 | 32,425 |
| **HTML** | 678 | 16,058 | 176 | 1,163 | 17,397 |
| **INI** | 136 | 11,496 | 1,669 | 1,882 | 15,047 |
| **CSS** | 12 | 5,033 | 190 | 950 | 6,173 |
| **Sass** | 102 | 4,448 | 647 | 993 | 6,088 |
| **TOML** | 51 | 3,539 | 82 | 413 | 4,034 |
| **Forge Config** | 77 | 2,527 | 85 | 239 | 2,851 |
| **PowerShell** | 15 | 2,496 | 230 | 384 | 3,110 |
| **Makefile** | 12 | 1,124 | 83 | 238 | 1,445 |
| **XML** | 17 | 1,018 | 55 | 36 | 1,109 |
| **Dockerfile** | 14 | 311 | 38 | 87 | 436 |
| **Other** | 31 | 881 | 442 | 437 | 1,760 |

### Key Insights
- **Primary Language**: Python dominates with 67.5% of all code (3.7M lines)
- **Configuration Files**: YAML is second most common with 472K lines across 21K files
- **Documentation**: ReStructuredText contains 374K lines of documentation
- **Internationalization**: PO files contribute 500K lines for translations

## Scripts

### `clone-openstack.sh`
Clones all 69 repositories from GitHub OpenStack organization with shallow clones (`--depth 1`).

### `analyze-dependencies.sh`
Analyzes Python dependencies across repos and finds cross-repo imports.

## Why OpenStack?

OpenStack represents the "holy shit what have I gotten myself into" level of complexity:
- **10+ years of development** - Nobody understands all of it
- **Multiple levels of abstraction**
- **Circular dependencies** through shared libs
- **Config files scattered everywhere**
- **Both infrastructure and application code**
- **Testing infrastructure as complex as the apps themselves**

This is the enterprise nightmare you're looking for.

## License

Individual repositories maintain their own licenses (primarily Apache 2.0 for OpenStack projects). This meta-repository is for organizational purposes only.
