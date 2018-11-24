# How to integrate an algorithm in the MIP


## Introduction

This document shows how to integrate an algorithm in the MIP. For this example, I chose to integrate an implementation of Anova that uses the StatsModels library for the core computation. One step in the integration process is done by inheriting from a parent Docker image. Depending on the technologies you need to run your algorithm, you'll have to use a different image than the one used in this tutorial. This tutorial has been tested on Ubuntu 16.04 LTS but should work on other operating systems.


## Prerequisites

* Git (https://git-scm.com)
* Docker (https://docs.docker.com/install/linux/docker-ce/ubuntu)
* Docker-compose (https://docs.docker.com/compose/install)
* Captain (https://github.com/harbur/captain)
* Bumpversion (https://pypi.org/project/bumpversion)


## Instructions

### 1. Projects cloning

Anova draft

`git clone ssh://git@lab01560.intranet.chuv:2222/mirco/anova-draft.git`

MIP Algorithm Template

`git clone ssh://git@lab01560.intranet.chuv:2222/mirco/mip-algorithm-template.git`

Testing environment

`git clone ssh://git@lab01560.intranet.chuv:2222/algorithm-factory/algorithm-factory-demo.git`


### 2. Template adaptation

Copy your algorithm sources, requirements, etc to the template project. You can either replace the `main.py` file or use a different file name, in which case you'll have to rename any reference to this file in the project.

`cp ../anova-draft/anova.py main.py`

`cp ../anova-draft/requirements-dev.txt requirements-dev.txt`

`cp ../anova-draft/requirements.txt requirements.txt`

You should also add the `mip_helper` to the `requirements.txt` file as we'll use this library to easily read and write data in the MIP.


### 3. Inputs reading

Replace the parsing of the command-line arguments in order to read the inputs using the mip_helper library:
```
inputs = io_helper.fetch_data()
dep_var = inputs["data"]["dependent"][0]
inped_vars = inputs["data"]["independent"]
design = parameters.get_parameter(DESIGN_PARAM, str, DEFAULT_DESIGN)
```
(I defined a constant `DESIGN_PARAM = "design"` but that's up to you).


### 4. Outputs writing

In order to store the data, you should use the following function:

`io_helper.save_results(anova_results, Shapes.JSON)`

Note that the output fromat must be a PFA document.


### 5. Useful functions and wrappers in the mip_helper library

Note that you can use a few predefined functions and wrappers in order to catch user errors for instance:

`raise errors.UserError('Dependent variable should be continuous!')`

and:

`` @utils.catch_user_error``


### 6. Building and Testing

To build the Docker image:

`./build.sh`

(Some unit-test can be executed at build time).

To run integration tests:

`./tests/test.sh`
