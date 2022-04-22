process trim_galore{

	container = 'mskaccess/trim_galore'
	
	input:
	tuple val(pair_id), path(reads)
	
	output:
	tuple val(pair_id), path("fastp_*_{1,2}_trimmed.fq"), emit: trimmed_reads 
	
	script:
	"""
	trim_galore ${reads}
	"""

}
