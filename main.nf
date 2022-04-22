nextflow.enable.dsl=2


params.reads = "/home/simon/Documents/GitHub/first-workflow/input/*_{1,2}.fq"
params.transcriptome = "/home/simon/first_workflow/input/hg19.fa"
params.gtf = "/home/simon/Documents/GitHub/first-workflow/input/ref-transcripts.gtf"

Channel.fromFilePairs(params.reads)
		.set{read_input_ch}
	

include {fastqc} from "./modules/fastqc"
include {fastp} from "./modules/fastp"
include {star_generate; star_align} from "./modules/star"
include {featurecounts} from "./modules/featurecounts"
include {hisat2_generate; hisat2_align} from "./modules/hisat2"
include {trim_galore} from "./modules/trim_galore"	
	
workflow rnaseq_small{	

	take:
		read_input
		gtf
		transcriptome


	main:

		fastp(read_input)
		reads = fastp.out.samples_fastp
		
		fastqc(reads)
		trim_galore(reads)
		preprocess_out = trim_galore.out.trimmed_reads
		
		
		if(!params.hisat2){
		
		star_generate(gtf, transcriptome)
		index = star_generate.out.index_star
		
		star_align(preprocess_out, index)
		quant = star_align.out.bam_files
		}else{
		
		hisat2_generate(transcriptome)
		index = hisat2_generate.out.hisat2_hts
		
		hisat2_align(preprocess_out, index, transcriptome)
		quant = hisat2_align.out.sam_files
		}
				
		featurecounts(quant, gtf)
			
}

workflow{

	rnaseq_small(read_input_ch, params.gtf, params.transcriptome)

}
