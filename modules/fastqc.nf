process fastqc{

	container = 'staphb/fastqc'
	
	input:
	tuple val(pair_id), path(reads)
	
	output:
	path("*_fastqc.html"), emit: fastqc_reports
	
	script:
	"""
	fastqc ${reads}
	"""
		
}

