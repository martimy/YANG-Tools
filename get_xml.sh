#!/bin/bash

export YANG_MODPATH=srlinux-yang-models


pyang -f sample-xml-skeleton \
--ignore-errors \
--sample-xml-skeleton-doctype=config \
--sample-xml-skeleton-defaults \
$1
