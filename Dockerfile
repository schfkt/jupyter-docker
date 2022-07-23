FROM jupyter/minimal-notebook:lab-3.4.3

USER root

RUN apt update -q &&\
    apt install -qy gcc make g++

COPY --from=golang:1.18.4 /usr/local/go/ /usr/local/go/
ENV PATH="/usr/local/go/bin:$PATH"

USER jovyan

# gophernotes
RUN go install github.com/gopherdata/gophernotes@v0.7.5 && \
    mkdir -p ~/.local/share/jupyter/kernels/gophernotes && \
    cd ~/.local/share/jupyter/kernels/gophernotes && \
    cp "$(go env GOPATH)"/pkg/mod/github.com/gopherdata/gophernotes@v0.7.5/kernel/*  "." && \
    chmod +w ./kernel.json && \
    sed "s|gophernotes|$(go env GOPATH)/bin/gophernotes|" < kernel.json.in > kernel.json

# ijavascript
RUN npm config set prefix $HOME && \
    npm install -g ijavascript@5.2.1
ENV PATH="$HOME/bin:$PATH"
RUN ijsinstall
