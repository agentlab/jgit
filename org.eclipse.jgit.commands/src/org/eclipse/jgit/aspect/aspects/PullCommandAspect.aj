package org.eclipse.jgit.aspect.aspects;

import org.eclipse.jgit.api.FetchCommand;
import org.eclipse.jgit.api.PullCommand;
import org.eclipse.jgit.api.PushCommand;
import org.eclipse.jgit.ext.commands.CommandPerformedEvent;

public aspect PullCommandAspect {

	/**
	 * Pointcut on {@link PullCommand} execution
	 * @param cmd
	 */
	pointcut execOnPull(org.eclipse.jgit.api.PullCommand cmd):
		execution(public org.eclipse.jgit.api.PullResult org.eclipse.jgit.api.PullCommand.call(..))
		&& this(cmd);

	/**
	 * Advice on {@link PullCommand}
	 * @param cmd
	 * @param res
	 */
	after(org.eclipse.jgit.api.PullCommand cmd) returning(org.eclipse.jgit.api.PullResult res): execOnPull(cmd) {
		if(res.isSuccessful())
			cmd.getRepository().fireEvent(new CommandPerformedEvent(cmd.getClass(), res));
	}

	/**
	 * Pointcut on {@link PushCommand} execution
	 * @param cmd
	 */
	pointcut execOnPush(org.eclipse.jgit.api.PushCommand cmd):
		execution(public java.lang.Iterable<org.eclipse.jgit.transport.PushResult> org.eclipse.jgit.api.PushCommand.call(..))
		&& this(cmd);

	/**
	 * Advice on {@link PushCommand}
	 * @param cmd
	 * @param res
	 */
	after(org.eclipse.jgit.api.PushCommand cmd) returning(java.lang.Iterable<org.eclipse.jgit.transport.PushResult> res): execOnPush(cmd) {
		if(!((java.util.ArrayList<?>)res).isEmpty())
			cmd.getRepository().fireEvent(new CommandPerformedEvent(cmd.getClass(), res));
	}

	/**
	 * pointcut on {@link FetchCommand}
	 * @param cmd
	 */
	pointcut execOnFetch(org.eclipse.jgit.api.FetchCommand cmd):
		execution(public org.eclipse.jgit.transport.FetchResult org.eclipse.jgit.api.FetchCommand.call(..))
		&& this(cmd);

	/**
	 * Advice on {@link FetchCommand}
	 * @param cmd
	 * @param res
	 */
	after(org.eclipse.jgit.api.FetchCommand cmd) returning(org.eclipse.jgit.transport.FetchResult res): execOnFetch(cmd) {
		cmd.getRepository().fireEvent(new CommandPerformedEvent(cmd.getClass(), res));
	}
	
	/**
	 * pointcut on {@link CherrryPick}
	 * @param cmd
	 */
	pointcut execOnCherryPick(org.eclipse.jgit.api.CherryPickCommand cmd):
		execution(public org.eclipse.jgit.api.CherryPickResult org.eclipse.jgit.api.CherryPickCommand.call(..))
		&& this(cmd);

	/**
	 * Advice on {@link FetchCommand}
	 * @param cmd
	 * @param res
	 */
	after(org.eclipse.jgit.api.CherryPickCommand cmd) returning(org.eclipse.jgit.api.CherryPickResult res): execOnCherryPick(cmd) {
		cmd.getRepository().fireEvent(new CommandPerformedEvent(cmd.getClass(), res));
	}
	
	/**
	 * pointcut on {@link CherrryPick}
	 * @param cmd
	 */
	pointcut execOnCheckout(org.eclipse.jgit.api.CheckoutCommand cmd):
		execution(public org.eclipse.jgit.api.CheckoutResult org.eclipse.jgit.api.CheckoutCommand.call(..))
		&& this(cmd);

	/**
	 * Advice on {@link FetchCommand}
	 * @param cmd
	 * @param res
	 */
	after(org.eclipse.jgit.api.CheckoutCommand cmd) returning(org.eclipse.jgit.api.CheckoutResult res): execOnCheckout(cmd) {
		cmd.getRepository().fireEvent(new CommandPerformedEvent(cmd.getClass(), res));
	}
}
