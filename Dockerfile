#    Copyright 2021 Robby Zapmino
#
#    This file is part of golang-unified-push-rewrite-proxy-docker.
#
#    golang-unified-push-rewrite-proxy-docker is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

FROM lsiobase/alpine:3.13 AS builder
ARG version=0.1.0
RUN apk update && apk add go curl
RUN mkdir -p /tmp/build/
WORKDIR /tmp/build
RUN curl -o up_rewrite.tar.gz -L https://github.com/karmanyaahm/golang-unified-push-rewrite-proxy/archive/v$version.tar.gz
RUN tar xzf up_rewrite.tar.gz
WORKDIR golang-unified-push-rewrite-proxy-$version
RUN go build
RUN cp up_rewrite /tmp/build

FROM lsiobase/alpine:3.13
COPY --from=builder /tmp/build/up_rewrite /usr/bin/
COPY root/ /
