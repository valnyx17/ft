# shellcheck disable=SC2148
# shellcheck disable=SC1091
# shellcheck disable=SC2154
source "$stdenv"/setup

buildPhase() {
   echo "put build phase here"
}

# if making an executable, uncomment the follow line. otherwise, delete it.
#
# installPhase() {
#    mkdir -p "$out"/bin
#    cp <executable> "$out"/bin
# }

genericBuild