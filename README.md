Docker build for Bochs (http://bochs.sourceforge.net)

# Building

```
docker build -t emanaev/bochs .
```

# Running

```
curl -sL http://bochs.sourceforge.net/guestos/freedos-img.tar.gz | tar -xz
docker run -it --rm -v $PWD/freedos-img/:/mnt -p 5900:5900 emanaev/bochs
```
