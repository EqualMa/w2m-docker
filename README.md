# weibo-to-mastodon docker

**Note** that currently `w2m` requires your mastodon instance to support status `content_type: text/html`.

Prepare `.w2mrc.json`, fill in the values.

```json
{
  "stopAfterFailed": true,
  "syncList": [
    {
      "weibo": { "userId": "<Your Weibo User Number Id>" },
      "mastodon": {
        "baseUrl": "<Your Mastodon Base Url Without Ending Slash>",
        "accessToken": "<Your Mastodon App Access Token>"
      }
    }
  ]
}
```

Then run:

```sh
docker run --rm -v "$(pwd)"/.w2mrc.json:/app/.w2mrc.json equalma/w2m
```
