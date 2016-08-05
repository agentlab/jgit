package com.github.jgit.test;

import java.io.File;

import org.eclipse.jgit.api.Git;
import org.eclipse.jgit.api.PullCommand;
import org.eclipse.jgit.api.PullResult;
import org.eclipse.jgit.ext.commands.CommandPerformedEvent;
import org.eclipse.jgit.ext.commands.CommandPerformedListener;
import org.eclipse.jgit.lib.Repository;
import org.eclipse.jgit.storage.file.FileRepositoryBuilder;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

public class Activator implements BundleActivator {

	private static BundleContext context;

	static BundleContext getContext() {
		return context;
	}

	/*
	 * (non-Javadoc)
	 * @see org.osgi.framework.BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	public void start(BundleContext bundleContext) throws Exception {
		Activator.context = bundleContext;
		System.out.println("Starting");
		File repoDir = new File("/home/xcariba/git/zuki-themes/.git");
		
		//------------------
		Repository.getGlobalListenerList().addListener(CommandPerformedListener.class, new CommandPerformedListener() {
			
			@Override
			public void onOperationPerformed(CommandPerformedEvent event) {
				System.out.println("Event: " + event.getCommandType());
				
			}
		});
		//------------------
		
		FileRepositoryBuilder builder = new FileRepositoryBuilder();
        try (Repository repository = builder.setGitDir(repoDir)
                .readEnvironment() // scan environment GIT_* variables
                .findGitDir() // scan up the file system tree
                .build()) {
           System.out.println("Repo found!");
           Git git = new Git(repository);
           System.out.println("Git Found");
           git.fetch().call();
           PullResult pull = git.pull().call();
           System.out.println("Pulled " + pull.getFetchedFrom());
        }
		
	}

	/*
	 * (non-Javadoc)
	 * @see org.osgi.framework.BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	public void stop(BundleContext bundleContext) throws Exception {
		Activator.context = null;
	}

}
