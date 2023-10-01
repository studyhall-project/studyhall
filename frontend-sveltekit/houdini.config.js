/// <references types="houdini-svelte">

/** @type {import('houdini').ConfigFile} */
const config = {
    "watchSchema": {
        "url": 'env:GRAPHQL_URL'
    },
    "plugins": {
        "houdini-svelte": {}
    }
}

export default config
