[![CircleCI](https://circleci.com/gh/KhalafMH/udacity-devops-project-4-ml-microservice-kubernetes.svg?style=svg)](https://circleci.com/gh/KhalafMH/udacity-devops-project-4-ml-microservice-kubernetes)

# Operationalize a Machine Learning Microservice API (Udacity Cloud DevOps Nanodegree Project 4)
Containerizing, Deploying, and Continuous Integration of a machine learning API.


In this project I take a machine learning model and associated python Flask API microservice source code for
running predictions using the model (both are provided by Udacity) and then wrap it in a Docker container and 
deploy it on a Kubernetes cluster. I also setup continuous integration of the sources using CircleCI where the
Dockerfile and Python source code are linted on every commit on the master branch.


## Running the Code

### Running Manually
To run the application manually follow these steps:
1. Make sure you have Python 3 and Make installed. You will also need to install the Python `virtualenv` package:
    ```shell script
    pip install virtualenv
    ```
2. Activate the python virtual environment by running:
    ```shell script
    make setup
    ``` 
3. Install the Python dependencies by running:
    ```shell script
    make install
    ```
4. Run the app.py script:
    ```shell script
    python app.py
    ```
5. Run a query against the api:
    ```shell script
   curl -d '{  
      "CHAS":{  
         "0":0
      },
      "RM":{  
         "0":6.575
      },
      "TAX":{  
         "0":296.0
      },
      "PTRATIO":{  
         "0":15.3
      },
      "B":{  
         "0":396.9
      },
      "LSTAT":{  
         "0":4.98
      }
   }'\
        -H "Content-Type: application/json" \
        -X POST http://localhost:80/predict
    ```

Note that the application uses port 80 which may require running as root.

### Running with Docker
The Docker image is already uploaded to Docker Hub under [khalafmh/sample-housing-prices-ml-api](https://hub.docker.com/khalafmh/sample-housing-prices-ml-api) 
and it can also be built using the Dockerfile at the root of this repository.

To run the Docker image and listen on port `8000`:
```shell script
docker run -d --name ml-api -p 8000:80 khalafmh/sample-housing-prices-ml-api
```
To make a prediction query against the container you can use the provided `make_prediction.sh` script which will make a
request to the application running on `localhost` and listening on port `8000`:
```shell script
./make_prediction.sh
```


## Project Files Structure
* All the source code files are under the root of the repository. These are:
    * `app.py`
    * `requirements.txt`
    * `Makefile`
    * `Dockerfile`

* All the helper scripts are also under the root of the repository. These are:
    * `run_docker.sh`
    * `run_kubernetes.sh`
    * `upload_docker.sh`
    * `make_prediction.sh`

* The trained model files are under `model_data/`.

* The CircleCI configuration is under `.circleci`.
