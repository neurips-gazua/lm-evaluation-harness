export tasks="babi,qa4mre,mmlu,race"
export adapters="predibase/magicoder predibase/conllpp predibase/dbpedia predibase/cnn \
predibase/agnews_explained predibase/gsm8k predibase/customer_support predibase/glue_qnli predibase/glue_mnli predibase/glue_sst2 \
predibase/glue_cola predibase/glue_stsb predibase/glue_mrpc predibase/glue_qqp predibase/tldr_headline_gen predibase/tldr_content_gen \
predibase/e2e_nlg predibase/wikisql predibase/ellaswag predibase/hellaswag_processed predibase/legal predibase/jigsaw predibase/bc5cdr \
predibase/covid predibase/drop predibase/drop_explained predibase/viggo"

export NNODES=1
export GPUS_PER_NODE=1
export CPUS_PER_TASK=16

for adapter in $adapters; do
    export job_name="llm-eval-$adapter"
    export JOB_NAME=$(echo "$job_name" | sed 's/\//_/g')
    run_cmd="sbatch --job-name $JOB_NAME --nodes $NNODES --gpus-per-node $GPUS_PER_NODE --ntasks-per-node $GPUS_PER_NODE --cpus-per-task $CPUS_PER_TASK $PWD/sbatch_eval.sh $adapter $tasks"
    echo $run_cmd 
    $run_cmd 
    wait
done