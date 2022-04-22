process featurecounts{

	container = 'dsaha0295/featurecounts'
	
	input:
	path(bam) 
	path(gtf) 
	
	output:
	path("*.counts.tsv"), emit: quant_out
	
	script:
	"""
	featureCounts -p -s 0 -a ${gtf} -o HSapiens.counts.tsv ${bam}
	"""
	
}
