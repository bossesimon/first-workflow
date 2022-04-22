process trim_galore{

	container = 'mskaccess/trim_galore'
	
	input:
	path(reads)
	
	output:
	path("${reads.baseName}_trimmed.fq"), emit: trimmed_reads
	
	script:
	"""
	trim_galore ${reads}
	"""

}
