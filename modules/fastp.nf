process fastp{	

	container = 'nanozoo/fastp'
	
	input: 
	tuple val(pair_id), path(reads)
	
	output: 
	tuple val(pair_id), path("fastp*{1,2}.fq"), emit: samples_fastp
		
	script:
	"""
	fastp -i ${reads[0]} -I ${reads[1]} -o fastp_${reads[0]} -O fastp_${reads[1]}
	"""
	
}

