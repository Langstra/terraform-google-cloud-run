/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module "cloud_run" {
  source = "../../"

  service_name = "ci-cloud-run"
  project_id   = var.project_id
  location     = "us-central1"
  image        = "us-docker.pkg.dev/cloudrun/container/hello"

  env_secret_vars = [
    {
      name = "SECRET_MESSAGE_TFVARS"
      value_from = [{
        secret_key_ref = {
          name = "cloud-run-env-var-1"
          key  = "1"
        }
      }]
    },
  ]

  service_annotations = {
    "run.googleapis.com/launch-stage" = "BETA"
  }
}
