## Authorize Github

-   Go to sandbox.fireflyblockchain.com
-   At the top right, click on "login"
-   At the Github OAuth screen, click on the "Authorize rv-jenkins" button

![](img/1authorize.png)

## Set up an access token

-   After being redirected, go to the "Products" drop-down in the top right and click on "test runner"

![](img/2testrunner.png)

-   Click on the "install now" button at the new page
-   Type in a name for your new token and click on "create"

![](img/3createtoken.png)

-   Save the token for later

## Set up and run Firefly

You can either install Firefly on your Ubunutu Bionic system or run it from a docker container

### On Ubuntu

TODO: Get the actual link for the debian package

```
wget https://www.github.com/runtimeverification/.../firefly_1.0.0_amd64.deb
sudo apt-get install firefly_1.0.0_amd64.deb

firefly launch <port>
```

### On Docker

```
docker run -p <port>:8545 --detach runtimeverificationinc:firefly
```

Where `<port>` is the port you want to access the client with

## Set up your repo for Firefly

In the base directory of your project:

```
firefly compile
firefly migrate
```

## Run the tests

```
firefly test
```

## Collect and upload coverage information

TODO: The token needs to be used here

```
firefly coverage
firefly upload
```

## Close the client

```
firefly close <port>
```

## View the report

-   Go back to sandbox.fireflyblockchain.com
-   In the upper right corner click on "Dashboard"
-   You will be shown a list of reports that have come back from CI. You can click on "Coverage" to view the coverage report

![](img/4coverage.png)
