process hisat2_generate{

	label 'hisat2'
	
	input: 
	path (transcriptome)
	
	output:
	path("*.ht2"), emit: hisat2_hts
	
	script:
	"""
	hisat2-build ${transcriptome} ${transcriptome.baseName}
	"""

}

process hisat2_align{

	label 'hisat2'
	
	input:
	tuple val(pair_id), path(reads) 
	path(index) 
	path(transcriptome) 
	
	output:
	path("*.sam"), emit: sam_files
	
	script:
	"""
	hisat2 -x ${transcriptome.baseName} -1 ${reads[1]} -2 ${reads[0]} -S ${reads[0].baseName}.sam --summary-file ${reads[0].baseName}_summary.log 
	"""

}	
