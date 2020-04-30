#!/usr/bin/env bash

function init-script() {
  local script_name="$1"

  cat <<HEREDOC
#!/usr/bin/env bash

source "\$(cd "\$(dirname "\${BASH_SOURCE[0]}")" && pwd)"/.init.sh

function $script_name() {
  # ...
  :
}

if [[ \${BASH_SOURCE[0]} != \$0 ]]; then
  export -f $script_name
else
  set -euo pipefail

  $script_name "\${@:-}"
  exit \$?
fi
HEREDOC
}

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f init-script
else
  set -euo pipefail

  init-script "${@:-}"
  exit $?
fi
