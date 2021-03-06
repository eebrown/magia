function corrected_ref_mask = anatomical_reference_region_correction2(original_ref_mask,tracer,seg_file)

V = spm_vol(original_ref_mask);
original_ref_mask = uint8(spm_read_vols(V));

switch lower(tracer)
    case {'[11c]carfentanil' '[18f]dopa'}
        corrected_ref_mask = shrink_oc_new(original_ref_mask,seg_file);
    case {'[11c]raclopride','[11c]madam','[11c]pib','[18f]spa-rq','[11c]pbr28'}
        voxel_sizes = sqrt(sum((V.mat(1:3,1:3)).^2,1));
        corrected_ref_mask = shrink_cer(original_ref_mask,voxel_sizes);
    otherwise
        warning('Anatomical reference region correction has not been implemented for %s.\n',tracer);
end

V.fname = add_postfix(V.fname,'_ac');
V.dt = [spm_type('uint8') spm_platform('bigend')];
V.pinfo = [Inf Inf Inf]';
spm_write_vol(V,corrected_ref_mask);
corrected_ref_mask = V.fname;

end