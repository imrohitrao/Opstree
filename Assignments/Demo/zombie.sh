#!/bin/bash

for i in {1..5}
do
  (
    exit 0     # 👶 Child exits immediately
  ) &          # 🚀 Runs in background
done

sleep 1000     # 😴 Parent stays alive, doesn't reap child
