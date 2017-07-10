function [] = style(look_and_feel)
% Function Information
% Parent - Various
% Description - Changes look and feel of GUI

drawnow; pause(0.05);

switch char(look_and_feel)
    case {'3D' 'Plastic3D' 'Plastic 3D'}
        str = 'com.jgoodies.looks.plastic.Plastic3DLookAndFeel';
    case {'Metal' 'metal'}
        str = 'javax.swing.plaf.metal.MetalLookAndFeel';
    case {'Nimbus' 'nimbus'}
        str = 'com.sun.java.swing.plaf.nimbus.NimbusLookAndFeel';
    case {'Motif' 'motif' 'CDE' 'CDE/Motif' 'CDE/motif'}
        str = 'com.sun.java.swing.plaf.motif.MotifLookAndFeel';
    case {'Windows' 'windows' 'New Windows' 'new windows'}
        str = 'com.sun.java.swing.plaf.windows.WindowsLookAndFeel';
    otherwise % Windows Classic is default
        str = 'com.sun.java.swing.plaf.windows.WindowsClassicLookAndFeel';
end

javax.swing.UIManager.setLookAndFeel(str);

end
