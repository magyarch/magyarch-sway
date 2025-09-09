#!/usr/bin/env bash
ratpoison -c "unbindall"
steam -applaunch "$1"
ratpoison -c "bindkeys"

