

# Dockerfile

镜像仓库: docker hub下 markhui

## 1 仓库->Dockerfile
- [x] iPlanner
- [ ] Mask2Former


## 2 问题记录

<aside>
💡 问题1：docker 每次运行还是需要sudo权限；这也是连不上vscode的原因
</aside>

```jsx
ERROR: permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/info": dial unix /var/run/docker.sock: connect: permission denied
```

- 解决方式：根据问题为无法访问的文件赋予权限,主要是以下两个问题
    - `sudo chmod 777 ~/.docker/config.json`
    - `sudo chmod 777 /var/run/docker.sock`

---

<aside>
💡 问题2：git 无法clone仓库【未完全解决】
</aside>

- 如果是使用了pigcha代理，那么在Dockerfile中加入以下git代理命令即可【不同的代理应该都是类似写法】：
    
    ```docker
    RUN git config --global http.proxy http://127.0.0.1:15777 && git config --global https.proxy http://127.0.0.1:15777
    ```
---

<aside>
💡 问题3：vscode docker处显示failed to connect
</aside>

- 将当前用户添加到docker用户组,然后重启
---

<aside>
💡 问题4：D435i 相机问题，docker下can not find
</aside>

- https://github.com/IntelRealSense/realsense-ros/issues/2926

---

- 问题5: AGX orin下python3.8:`import cv2` 报错importError: libpng16-45e47e2f.so.16.40.0: cannot open shared object file: No such file or directory
    
    `cp /usr/lib/python3/dist-packages/cv2.cpython-38-aarch64-linux-gnu.so /usr/lib/python3.8/`将这个so库放入到python3.8下
    
- 问题6: git clone: **GnuTLS recv error (-110): The TLS connection was non-properly terminated**    
    
    ```jsx
    imaginemiracle@im-Linux:~$ sudo apt-get update
    imaginemiracle@im-Linux:~$ sudo apt-get install gnutls-bin
    imaginemiracle@im-Linux:~$ git config --global http.sslVerify false
    imaginemiracle@im-Linux:~$ git config --global http.postBuffer 1048576000
    ```