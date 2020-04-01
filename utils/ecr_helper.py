#!/usr/bin/python

import click
import os
import boto3

aws_region = os.environ.get("AWS_REGION", "eu-west-2")

ecr_client = boto3.client(
    'ecr',
    region_name=aws_region
)


def create_repository(name: str):
    """
        Creates AWS ECR repo

        Parameters:
        name = repository name

        Returns:
            Dict containing fields:
                - message = information
                - exit_code = code used to determine success or failure
                - error = error information if any occur
                - status = success or failed
    """
    response_obj = {
        "message": f"Repository {name} created",
        "status": "success",
        "exit_code": 0
    }
    try:
        ecr_client.create_repository(
            repositoryName=name
        )
    except ecr_client.exceptions.RepositoryAlreadyExistsException:
        response_obj.update({
            "message": f"Repository {name} already exists, skipping creation",
            "status": "not created"
        })
    except Exception as err:
        response_obj.update({
            "message": "An error occurred creating repository",
            "status": "failed",
            "error": str(err),
            "exit_code": 21
        })
    return response_obj


def get_repository(name: str):
    """
        Retrieves AWS ECR repo

        Parameters:
        name = repository name

        Returns:
            Dict containing fields:
                - message = information
                - exit_code = code used to determine success or failure
                - status = success or failed
    """
    response_obj = {
        "message": f"Repository {name} found",
        "status": "success",
        "exit_code": 0
    }
    try:
        response = ecr_client.describe_repositories(repositoryNames=[name, ])
        if 'repositories' in response:
            response_obj['data'] = response['repositories'][0]
    except ecr_client.exceptions.RepositoryNotFoundException as err:
        response_obj.update({
            "message": "Repository not found",
            "status": "failed",
            "error": str(err),
            "exit_code": 22
        })
    except Exception as err:
        response_obj.update({
            "message": "An error occurred",
            "status": "failed",
            "error": str(err),
            "exit_code": 23
        })
    return response_obj
