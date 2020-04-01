# utils/manage.py

import click
import sys

from ecr_helper import create_repository, get_repository
from github_helper.releases import Release_Handler


@click.group()
def cli():
    pass


@cli.command()
@click.option('-r', '--repo', required=True, type=str)
def ecr_add_repo(repo: str):
    """
        Creates AWS ECR repo
    """
    resp = create_repository(repo)
    message = resp['message']
    if resp['exit_code'] != 0:
        message = resp['error']
        click.echo(message=message)
        return sys.exit(resp['exit_code'])
    click.echo(message=message)
    return sys.exit(0)


@cli.command()
@click.option('-r', '--repo', required=True, type=str)
def ecr_get_repo(repo: str):
    """
        Retrieves AWS ECR repo
    """
    resp = get_repository(repo)

    if resp['exit_code'] != 0:
        message = resp['error']
        click.echo(message=message)
        return sys.exit(resp['exit_code'])
    repo_uri = resp['data']['repositoryUri']
    click.echo(message=repo_uri)
    return sys.exit(0)

@cli.command()
def get_build_version():
    """
        Get docker build version tag
    """
    resp = {
        'message': 'No version found',
        'exit_code': 1
    }
    manager = Release_Handler()
    version = manager.get_new_release_version()
    if version:
        resp['tag'] = version
        resp['message'] = 'success'
        resp['exit_code'] = 0

    if resp['exit_code'] != 0:
        message = resp['message']
        click.echo(message=message)
        return sys.exit(resp['exit_code'])
    click.echo(message=resp['tag'])
    return sys.exit(0)

@cli.command()
@click.option('-b', '--branch', required=True, type=str)
@click.option('-sha', '--commit', required=True, type=str)
def create_release(branch: str, commit: str):
    """
        Manages Github repo releases
    """
    manager = Release_Handler()
    resp = manager.task_handler(branch, commit)
    message = resp['message']
    if resp['exit_code'] != 0:
        message = resp['error']
        click.echo(message=message)
        return sys.exit(resp['exit_code'])
    click.echo(message=message)
    return sys.exit(0)

if __name__ == '__main__':
    cli()
