#!/usr/bin/env nextflow

/*Channel.fromFilePairs("/data/Nextflow_Data/test-datasets/fastq/*_{1,2}.fastq.gz", checkIfExists: true)
    .set{ ch_reads }

Channel.fromPath("/data/fust1_rep1_1.fastq.gz")
    .set{ ch_pheno }
ch_pheno.view()
*/

/*
Channel.fromFilePairs("*_{1,2}.fastq.gz", checkIfExists: true)
    .set{ ch_reads1 }
ch_reads1.view()

Channel.fromFilePairs("/data/*_{1,2}.fastq.gz", checkIfExists: true)
    .set{ ch_reads2 }
ch_reads2.view()
*/

Channel.fromFilePairs( params.input, checkIfExists: true )
    .set{ ch_reads }

process FASTQC{

    echo true

    publishDir "./fastqc", mode: 'copy'

    input:
    tuple val(base), file(reads) from ch_reads

    output:
    tuple val(base), file("*.{html,zip}") into ch_multiqc

    /*script:
    """
    readlink -f /data/*
    """
    */

    script:
    """
    fastqc -q ${reads}
    multiqc ./fastqc
    """
}
