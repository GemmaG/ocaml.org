
export OPAMYES=1

# $HOME/.opam is cached, hence always present.
if [ -f "$HOME/.opam/config" ]; then
    opam update || UPDATE_FAILED="yes"
    opam upgrade || UPGRADE_FAILED="yes"
    if [ -n "$UPDATE_FAILED"  -o  -n "$UPGRADE_FAILED" ]; then
        # Something went wrong, restart from scratch
        rm -rf "$HOME/.opam/"
        opam init
    fi
else
    opam init
fi

if [ -n "${OPAM_SWITCH}" ]; then
    opam switch ${OPAM_SWITCH}
fi
eval `opam config env`

opam pin add opam2web https://github.com/Chris00/opam2web.git#opl
make deps

export OCAMLRUNPARAM=b
make -j 2
