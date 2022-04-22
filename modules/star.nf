process star_generate{

	container = 'otiai10/star-alignment'
	
	input:
	path(gtf) 
	path(transcriptome) 
	
	output:
	path './star_generate', emit: index_star
	
	script:
	"""
	mkdir star_generate
	STAR --runMode genomeGenerate --genomeDir ./star_generate --genomeFastaFiles ${transcriptome} --sjdbGTFfile ${gtf}
	"""	

}

process star_align{

	container = 'otiai10/star-alignment'
    
	input:
	tuple val(pair_id), path(reads) 
	path(index) 

	output:
	path("*.bam"), emit: bam_files
    
	script:
	"""
	STAR --genomeDir ${index} --readFilesIn ${reads[0]} ${reads[1]} --outSAMtype BAM SortedByCoordinate --outFileNamePrefix star_align --quantMode GeneCounts
	"""

}

