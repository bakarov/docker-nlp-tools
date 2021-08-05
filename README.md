# Docker container for NLP stuff

https://hub.docker.com/r/defeater/nlp-tools/

```docker pull defeater/nlp-tools```


## Troubleshooting

1. On MacOS: `failed to solve with frontend dockerfile.v0: failed to build LLB: executor failed running - runc did not terminate sucessfully`

`export DOCKER_BUILDKIT=0`
`export COMPOSE_DOCKER_CLI_BUILD=0`
