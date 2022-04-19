nextflow.enable.dsl=2


params.reads = "/home/simon/Documents/GitHub/first-workflow/input/*_{1,2}.fq"
params.transcriptome = "/home/simon/first_workflow/input/*.fa"
params.gtf = "/home/simon/Documents/GitHub/first-workflow/input/*.gtf"

Channel.fromFilePairs(params.reads)
		.set{read_input_ch}
	

include {fastp} from "./modules/fastp"
include {star_generate; star_align} from "./modules/star"
	
workflow rnaseq_small{	

	take:
		read_input_ch
		gtf
		transcriptome

	main:
		fastp(read_input_ch)
		reads = fastp.out.samples_fastp
		star_generate(gtf, transcriptome)
		index = star_generate.out.index_star
		star_align(reads, index)
	
}

workflow{

	rnaseq_small(read_input_ch, params.gtf, params.transcriptome)

}
