#!/bin/bash

main() {

  echo "=== Setup ==="
  echo "  [*] Downloading input files..." 
  dx-download-all-inputs --parallel > /dev/null

  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/dnanexus/

  echo "  [*] Running Fuzzion ..."

  fuzzion $BAM_path 3 2 < /home/dnanexus/fuzzion_targets.txt > $BAM_prefix.fuzzion.txt

  touch $BAM_prefix.fuzzion.txt

  echo "  [*] Output is ..."  
  cat $BAM_prefix.fuzzion.txt

  echo "Finished running Fuzzion"
  fusions=$(dx upload $BAM_prefix.fuzzion.txt --brief)
  dx-jobutil-add-output fusions "$fusions" --class=file
}
