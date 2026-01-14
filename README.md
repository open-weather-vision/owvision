# Create your own weather control center, for free!

**open weather vision** (_owvision_ in short) is a _software system_ that allows you to

-   record
-   archive
-   analyze

and

-   share

the weather data of your _personal weather station(s)_. It is a self-hostable, open source solution. You only need a Raspberry Pi visible in your network (or in the whole world😉) to get started!

**[To get started read the official documentation!](https://open-weather-vision.github.io/owvision/)**

## About this repository

This repository is a mono repository holding the different building blocks of owvision.

### ⚙️📊 The central processing unit - The "daemon"

The [**daemon**](./daemon/README.md) is responsible for processing and managing each weather station's data inside a sqlite database. It is also responsible for providing a convenient, secured interface in form of a RESTful API and websockets. It is written in [Dart](https://dart.dev/).
It comes packed with a _cli_ called **owvi** which allows you to manage your station(s) without any complex gui.

### 🔴📹 A flexible input buffer - The "recorder"

The [**recorder**](./recorder/README.md) is responsible for connecting to a weather station via an interface and sending buffered weather station data to the daemon via [gRPC](https://grpc.io/). The daemon is also written in [Dart](https://dart.dev/). It is flexible, lightweight and robust, e.g. is able to deal with connection issues of many kinds and can run on lowpower devices like a Raspberry Pi.
It comes packed with a _cli_ called **owrec**.

### 📊🪄 An easy to user graphical user interface - The "dashboard"

The [**dashboard**](./dashboard/README.md) is the entry point for most users. Live and historic weather data is **visualized** in a modern, intuitive way by default✨. There is support for themes, light☀️ and dark mode🌙. Communicates with the "daemon" in the background.

It also comes with an admin panel, that allows you to manage your weather stations and their data🛠️.
