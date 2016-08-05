package org.eclipse.jgit.aspect.aspects;

public aspect PullCommandAspect {

	pointcut execOnPull():
		execution(public Object org.eclipse.jgit.api.*.call(..));
	
	after() returning(Object obj): execOnPull() {
		try {
			Object o = thisJoinPoint.getKind();
			System.out.println(o.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("SUPER MEGA CHECK1: " + obj.toString());
	}

	after() returning(): execOnPull() {

		System.out.println("SUPER MEGA CHECK2");
	}

}
