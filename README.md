# Jeco

My pet container.

```
docker build . -t jeco
docker run -v $HOME:$HOME -v /var/run/docker.sock:/var/run/docker.sock -it jeco
```
