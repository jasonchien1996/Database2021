import java.util.Scanner;

public class Noise {
    public Noise(){}
	public static String parse(String line) throws Exception{
		Scanner s = new Scanner(line);
		float prob;
		String mode;
		int i1, i2;
		try{
			prob = s.nextFloat();
			s.next();
			mode = s.next();
			i1 = s.nextInt();
			i2 = s.nextInt();
			if(prob > 1 || s.hasNext())
				throw new Exception();
		} 
		finally{
			s.close();
		}	
		String code = String.format("if(((float)(rand()%%100))/100.0 < %s) tmp = __noise(tmp,\"%s\",%s,%s);\n",prob,mode,i1,i2);
		return code;
	}
}
