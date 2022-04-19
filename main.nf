nextflow.enable.dsl=2

params.reads = "./input/*_{1,2}.fq"
params.transcriptome = "/home/simon/first_workflow/input/*.fa"
params.gtf = "./input/*.gtf"

Channel.fromFilePairs(params.reads)
		.tap{read_input_ch}

include {fastp} from "./modules/fastp"
	
workflow preprocessing{	

	take:
		read_input_ch

	main:
		fastp(read_input_ch)

}

workflow{

	preprocessing(read_input_ch)

}
