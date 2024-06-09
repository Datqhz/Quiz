# Quiz
## Requirements
* Docker Desktop - Step by step to install [here](https://docs.docker.com/engine/install/).
* Flutter SDK

## Getting started
### Installation
1. **Pull docker images**
    - Navigate to `run-guest` directory
    ```
    cd run-guest
    ```
    - Pull all docker images
    ```
    docker-compose pull
    ```
2. **Build docker images**
    ```
    docker-compose build
    ```
3. **Setup database**
    - Run `images` quiz-mysql
    ```
    docker-compose up quiz-mysql
    ```
    - Connect to `quiz-mysql` server with connection info:
    > hostname: 127.0.0.1;
    > port 3308;
    > usename: root;
    > password: your password setup in `.env` file
    - Create new databases with name `TaskService` and `UserService`.
    - Run script file for each databases (task-service-script for TaskService and myuser-service-script for UserService)
4. **Run all images as containers**
    ```
    docker-compose up -d
    ```
    wait a minutes for all container start
5. **Setup front-end**
    - Go to `root` directory
    ```
    cd..
    ```
    - Navigate to `quiz` directory
    ```
    cd \quiz
    ```
    - Install all dependencies
    ```
    flutter pub get
    ```
    - Run the flutter app
    ```
    flutter run
    ```
### API Documentation
To approach all APIs of mine. You need **Postman** to do this, [here](https://www.postman.com/) is how to getting start to use **Postman**.
Import APIs by use `task-service-apis` file and `myuser-service-apis`.
1. Open Postman and click `Import` button in `Workspace`
![](https://res.cloudinary.com/dyhjqna2u/image/upload/v1717062510/yhgu7v57zir9lzzua7np.png)
2. Choose `Select file or your folder` option
![](https://res.cloudinary.com/dyhjqna2u/image/upload/v1717061707/bb7brdsrllrefujr5hs0.png)

**Result you receive after all**

![](https://res.cloudinary.com/dyhjqna2u/image/upload/v1717061980/fu6ywdl5njdgzk7882i5.png)

>Choose `View documentation` on each API collection to see what will happen when you use API to do something.


