# syntax = docker/dockerfile:1.0-experimental
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM gcr.io/distroless/static
WORKDIR /app

# Set an env var that matches your github repo name, replace treeder/dockergo here with your repo name
ENV GO111MODULE=on

# Setup our deployment
COPY site /app/site/
COPY third_party /app/third_party/
COPY config.yaml /app/config.yaml
COPY .site-cache /app/site-cache
COPY app /app/main

# Run the server at a reasonable refresh rate
CMD ["/app/main", "--max_list_age=120s", "--max_refresh_age=20m", "--config=/app/config.yaml", "--site_dir=/app/site", "--3p_dir=/app/third_party", "--init_cache=/app/site-cache"]
