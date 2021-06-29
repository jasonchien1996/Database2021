import java.util.Scanner;

public class Gaussianblur {
    public Gaussianblur(){}
	public static String parse(String line) throws Exception{
		Scanner s = new Scanner(line);
		float prob;
		float w, h, sigmaX, sigmaY;
		try{
			prob = s.nextFloat();
			s.next();
			w = s.nextFloat();
			h = s.nextFloat();
			sigmaX = s.nextFloat();
			sigmaY = sigmaX;
			if(s.hasNext()){
				sigmaY = s.nextFloat();
			}
			if(prob > 1 || s.hasNext())
				throw new Exception();
		} 
		finally{
			s.close();
		}
		String code = String.format("if(((float)(rand()%%100))/100.0 < %s) tmp = __gaussianblur(tmp,%s,%s,%s,%s);\n", prob,w,h,sigmaX,sigmaY);
		return code;
	}
}
