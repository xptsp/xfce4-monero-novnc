# Docker XFCE desktop over HTTP running Monero GUI Wallet

A lightweight Linux workstation based on [Debian](https://debian.org/) that launches the
Monero GUI Wallet app automatically at startup. Provides a **graphical desktop** via HTTP,
as well as a VNC connection.

**Based on one project**
 * [TheHolm/xfce4-desktop-over-http](https://github.com/TheHolm/xfce4-desktop-over-http)

![Screenshot](https://github.com/xptsp/xfce4-monero-novnc/blob/main/files/screenshot.png?raw=true)

## Main packages

* **xfce4**   : Graphic desktop environment
* **x11vnc**  : X vnc server
* **novnc**    : HTTP-to-VNC gateway
* **firefox-esr** : Web browser
* **chromium**    : Web browser
* [Monero GUI Wallet](https://www.getmonero.org/downloads/)

## Usage (synopsis)

```
services:
  monero:
    image: xptsp/xfce4-monero-novnc:latest
    container_name: monero
    environment:
      - TZ=America/Chicago  # Your timezone
      - XRES=1440x900x24    # Defaults to 1280x800x24
    volumes:
      - ./data:/home/user/.bitmonero        # Monero GUI Wallet Data location
      - ./blocks:/home/user/.bitmonero/lmdb # Blockchain storage location
    ports:
      - 6080:6080   # noVNC HTTP Port
      - 5900:5900   # x11vnc Port
    restart: unless-stopped
```

Connect to the virtual computer using any modern web browser by browsing to [<IP>:6080](http://127.0.0.1:6080).

## Changelog:

**v0.18.4.4-2:**
- User "user" now has password "password" by default.  Original password is unknown.
- A few minor changes to Terminal settings.

**v0.18.4.4:**
- Initial release of image
