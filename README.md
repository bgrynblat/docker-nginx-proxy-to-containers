# How it works ?

Just run the container with 2 environment variables :

- `ENVS`: the list of the environments (see below)
- `DEFAULT`: the default url to proxy to (default: `http://localhost`)

Based on the host the request has been made to, nginx will point to the good environment or the default one.

## `ENVS` format

Each environment must be defined as below :
`<host regex>;<environment name>;<url to proxy>`

- Example: `qat.*;qat;http://localhost:3000`

The `ENVS` variable should define one or more environments, separated by spaces (ie. `<env1> <env2> <env3>...`)

- Example: `uat.*;uat;http://localhost:3000 staging.*;staging;http://localhost:3001`