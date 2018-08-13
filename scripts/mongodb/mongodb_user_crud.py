#!/usr/bin/env python

"""
Example usage:
./mongodb_user_crud.py -e staging -t cfg -o create
python mongodb_user_crud.py -e staging -t cfg -o create
"""

__author__ = "Zaidan Sheabar"


import argparse
import logging
import sys

from pymongo import MongoClient
from mdb_server_config import hosts
from mdb_user_config import *


# general logger
logging.basicConfig(level=logging.INFO)
mdb_log = logging.getLogger(__name__)


class MongoDbManager(object):
    def __init__(self, ip, username, password):
        """
        Initialize the class
        :param ip: private or public IP of the server
        :param username: login username for the mongod or mongos instance (needs user management permissions)
        :param password: login password for the above user
        """

        self.client = MongoClient(host=ip, port=27017, authSource="admin", username=username, password=password)

    def is_master(self):
        """
        Checks if the current server is the master of its replica set (RS)
        :return: boolean
        """

        db = self.client["admin"]

        try:
            return db.command("isMaster")["ismaster"]
        except Exception, e:
            mdb_log.error(e)

    def create_user(self, new_user, new_pass, roles):
        """
        Creates a new MongoDB user
        :param new_user: new username to create
        :param new_pass: password of the new user to create
        :param roles: roles belonging to the newly created user
        :return: string (success/failure)
        """

        db = self.client["admin"]

        try:
            db.command("createUser", new_user, pwd=new_pass, roles=roles)
            return "success"
        except Exception, e:
            mdb_log.error(e)
            return "failure"

    def delete_user(self, curr_user):
        """
        Deletes a MongoDB user
        :param curr_user: name of the user to delete
        :return: string (success/failure)
        """

        db = self.client["admin"]

        try:
            db.command("dropUser", curr_user)
            return "success"
        except Exception, e:
            mdb_log.error(e)
            return "failure"

    def update_pass(self, curr_user, new_pass):
        """
        Updates an existing MongoDB user's password
        :param curr_user: name of the user to update
        :param new_pass: new password for the update
        :return: string (success/failure)
        """

        db = self.client["admin"]

        try:
            db.command("updateUser", curr_user, pwd=new_pass)
            return "success"
        except Exception, e:
            mdb_log.error(e)
            return "failure"

    def update_roles(self, curr_user, new_roles):
        """
        Updates an existing MongoDB user's roles
        :param curr_user: name of the user to update
        :param new_roles: new role(s) for the update
        :return: string (success/failure)
        """

        db = self.client["admin"]

        try:
            db.command("updateUser", curr_user, roles=new_roles)
            return "success"
        except Exception, e:
            mdb_log.error(e)
            return "failure"


def crud_user_credentials(env, srv_type, operation):
    """
    Manages the creation, updates, and deletion of MongoDB user credentials
    :param env: working environment of the MongoDB server
    :param srv_type: server type to work with
    :param operation: operation to perform on the user(s)
    :return: n/a
    """

    all_hosts = hosts[env]["cfg"] + hosts[env]["rs"] if srv_type == "all" else hosts[env][srv_type]

    for mdb_host in all_hosts:
        mdb_mgr = MongoDbManager(ip=mdb_host["ip"], username=admin["user"], password=admin["pass"])

        for user in users:
            if ("config" or "cfg" in mdb_host["host"]) or (mdb_mgr.is_master() is True):
                if operation == "create":
                    resp = mdb_mgr.create_user(new_user=user["name"], new_pass=user["pass"], roles=user["roles"])
                elif operation == "delete":
                    resp = mdb_mgr.delete_user(curr_user=user["name"])
                elif operation == "update-pass":
                    resp = mdb_mgr.update_pass(curr_user=user["name"], new_pass=user["pass"])
                elif operation == "update-roles":
                    resp = mdb_mgr.update_roles(curr_user=user["name"], new_roles=user["roles"])
                else:
                    mdb_log.error("Invalid operation.")
                    sys.exit()

                mdb_log.info("Host: %s user %s: %s" % (mdb_host["host"], operation, resp))


def get_parser():
    """
      Builds the primary script parser
      :return: parser object
    """

    args_desc = "Script to create MongoDB users and/or update their passwords"
    parser_main = argparse.ArgumentParser(description=args_desc)
    parser_main.add_argument("-e", "--env", help="working environment name", choices=hosts.keys())
    parser_main.add_argument("-t", "--srv-type", help="type of MongoDB server to operate on",
                             choices=["cfg", "rs", "all"])
    parser_main.add_argument("-o", "--oper", help="operation to perform on a user",
                             choices=["create", "delete", "update-pass", "update-roles"])

    return parser_main


if __name__ == "__main__":
    parser = get_parser()
    args = parser.parse_args()
    mdb_log.info("Current arguments: %s" % args)

    crud_user_credentials(env=args.env, srv_type=args.srv_type, operation=args.oper)
